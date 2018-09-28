module Explicit.Classes.Constructors.Applicative where

import Explicit.Prelude hiding (ap, map, Functor, Applicative, Monad)
import Explicit.Classes.Types
import qualified Explicit.Classes.Accessors.Monad as MonadAccessors
import qualified Explicit.Classes.Accessors.Pointed as PointedAccessors
import qualified Explicit.Classes.Constructors.Apply as Apply


{-|
Useful for interesting combinations.
For instance, when you use the 'sequentialMonad' and 'concurrentExtend' instances for IO,
this instance will perform concurrently.
-}
monadAndExtend :: Monad m -> Extend m -> Applicative m
monadAndExtend monad extend = Applicative (MonadAccessors.pointed monad) (Apply.monadAndExtend monad extend)
