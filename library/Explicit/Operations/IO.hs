module Explicit.Operations.IO where

import Explicit.Prelude hiding (map)
import qualified Explicit.Prelude as Prelude


fork :: IO a -> IO (IO a)
fork = \ ioA ->
  newEmptyMVar & 
  joinMap (\ var -> forkIO (ioA & joinMap (putMVar var)) & 
  map (const (takeMVar var)))

map :: (a -> b) -> IO a -> IO b
map = fmap

joinMap :: (a -> IO b) -> IO a -> IO b
joinMap = (Prelude.=<<)

apSequentially :: IO (a -> b) -> IO a -> IO b
apSequentially = \ ioAToB ioA -> joinMap (\ aToB -> map aToB ioA) ioAToB

apConcurrently :: IO (a -> b) -> IO a -> IO b
apConcurrently = \ ioAToB ioA -> joinMap (\ ioAToB -> apSequentially ioAToB ioA) (fork ioAToB)
