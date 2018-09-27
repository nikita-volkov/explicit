module Explicit.Operations.IO where

import Explicit.Prelude hiding (map)
import qualified Explicit.Prelude as Prelude


duplicate :: IO a -> IO (IO a)
duplicate =
  \ioA ->
    newEmptyMVar & 
    joinMap (\var -> forkIO (ioA & joinMap (putMVar var)) & 
    map (const (takeMVar var)))

map :: (a -> b) -> IO a -> IO b
map =
  fmap

joinMap :: (a -> IO b) -> IO a -> IO b
joinMap =
  (Prelude.=<<)

sequentialAp :: IO (a -> b) -> IO a -> IO b
sequentialAp = 
  \ioAToB ioA -> joinMap (\aToB -> map aToB ioA) ioAToB

concurrentAp :: IO (a -> b) -> IO a -> IO b
concurrentAp = 
  \ioAToB ioA -> joinMap (\ioAToB -> sequentialAp ioAToB ioA) (duplicate ioAToB)
