module Explicit.Operations.IO where

import Explicit.Prelude hiding (map)
import qualified Explicit.Prelude as Prelude


fork :: IO a -> IO (IO a)
fork = \ ioA ->
  newEmptyMVar & 
  joinMap (\ var -> forkIO (ioA & joinMap (putMVar var)) & 
  map (const (takeMVar var)))

compete :: IO a -> IO a -> IO a
compete a b = do
  aVar <- newTVarIO Nothing
  bVar <- newTVarIO Nothing
  forkIO $ do
    !aResult <- a
    atomically $ do
      writeTVar aVar (Just aResult)
  forkIO $ do
    !bResult <- b
    atomically $ do
      writeTVar bVar (Just bResult)
  atomically $ mplus
    (do
      aContents <- readTVar aVar
      case aContents of
        Just a -> return a
        Nothing -> empty)
    (do
      bContents <- readTVar bVar
      case bContents of
        Just b -> return b
        Nothing -> empty)

map :: (a -> b) -> IO a -> IO b
map = fmap

joinMap :: (a -> IO b) -> IO a -> IO b
joinMap = (Prelude.=<<)

apSequentially :: IO (a -> b) -> IO a -> IO b
apSequentially = \ ioAToB ioA -> joinMap (\ aToB -> map aToB ioA) ioAToB

apConcurrently :: IO (a -> b) -> IO a -> IO b
apConcurrently = \ ioAToB ioA -> joinMap (\ ioAToB -> apSequentially ioAToB ioA) (fork ioAToB)


