module Explicit.Instances.IO where

import Explicit.Prelude
import qualified BasePrelude as Base
import qualified Explicit.Classes.Functor as Functor
import qualified Explicit.Classes.Ap as Ap
import qualified Explicit.Classes.Applicative as Applicative
import qualified Explicit.Classes.Monad as Monad


functor :: Functor.Functor IO
functor =
  Functor.Functor Base.fmap

joinMap :: Monad.JoinMap IO
joinMap =
  Monad.JoinMap (Base.=<<)

sequentialAp :: Ap.Ap IO
sequentialAp =
  Ap.Ap $ \ioAToB ioA -> (Base.=<<) (\aToB -> Base.fmap aToB ioA) ioAToB

concurrentAp :: Ap.Ap IO
concurrentAp =
  Ap.Ap $ \ioAToB ioA -> (Base.=<<) (\ioAToB -> Ap.ap sequentialAp ioAToB ioA) (fork ioAToB)

  
-- ** Utilities
-------------------------

fork :: IO a -> IO (IO a)
fork =
  \ioA ->
    Base.newEmptyMVar & 
    (Base.=<<) (\var -> Base.forkIO (ioA & (Base.=<<) (putMVar var)) & 
    Base.fmap (const (takeMVar var)))
