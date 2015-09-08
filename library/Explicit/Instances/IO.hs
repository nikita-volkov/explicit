module Explicit.Instances.IO where

import Explicit.Prelude
import qualified BasePrelude as Base
import qualified Explicit.Classes.Functor as Functor
import qualified Explicit.Classes.Ap as Ap
import qualified Explicit.Classes.Applicative as Applicative
import qualified Explicit.Classes.Monad as Monad
import qualified Explicit.Classes.Semigroup as Semigroup
import qualified Explicit.Operations.IO as IO


functor :: Functor.Functor IO
functor =
  Functor.Functor Base.fmap

joinMap :: Monad.JoinMap IO
joinMap =
  Monad.JoinMap (Base.=<<)

sequentialAp :: Ap.Ap IO
sequentialAp =
  Ap.Ap functor IO.sequentialAp

concurrentAp :: Ap.Ap IO
concurrentAp =
  Ap.Ap functor IO.concurrentAp

sequentialSemigroup :: Semigroup.Semigroup a -> Semigroup.Semigroup (IO a)
sequentialSemigroup =
  Ap.map2 sequentialAp

concurrentSemigroup :: Semigroup.Semigroup a -> Semigroup.Semigroup (IO a)
concurrentSemigroup =
  Ap.map2 concurrentAp

