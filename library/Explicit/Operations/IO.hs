module Explicit.Operations.IO where

import Explicit.Prelude
import qualified BasePrelude as Base


duplicate :: IO a -> IO (IO a)
duplicate =
  \ioA ->
    Base.newEmptyMVar & 
    joinMap (\var -> Base.forkIO (ioA & joinMap (putMVar var)) & 
    map (const (takeMVar var)))

map :: (a -> b) -> IO a -> IO b
map =
  Base.fmap

joinMap :: (a -> IO b) -> IO a -> IO b
joinMap =
  (Base.=<<)

sequentialAp :: IO (a -> b) -> IO a -> IO b
sequentialAp = 
  \ioAToB ioA -> joinMap (\aToB -> map aToB ioA) ioAToB

concurrentAp :: IO (a -> b) -> IO a -> IO b
concurrentAp = 
  \ioAToB ioA -> joinMap (\ioAToB -> sequentialAp ioAToB ioA) (duplicate ioAToB)
