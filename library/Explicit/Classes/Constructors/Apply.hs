module Explicit.Classes.Constructors.Apply where

import Explicit.Prelude hiding (ap, map, Functor, Applicative, Monad)
import Explicit.Classes.Types
import qualified Explicit.Classes.Accessors.Functor as Functor
import qualified Explicit.Classes.Accessors.Monad as Monad
import qualified Explicit.Classes.Accessors.Bind as Bind
import qualified Explicit.Classes.Accessors.Extend as Extend
import qualified Explicit.Classes.Accessors.Apply as Apply


ap :: Functor m -> (forall a b. m (a -> b) -> (m a -> m b)) -> Apply m
ap functor ap = Apply functor ap
  (\ a b -> ap (Functor.map functor (const id) a) b)
  (\ a b -> ap (Functor.map functor const a) b)
  (\ f a b -> ap (Functor.map functor f a) b)

applicative :: Applicative m -> Apply m
applicative (Applicative _ apply) = apply

{-|
Useful for interesting combinations.
For instance, when you use the 'sequentialMonad' and 'concurrentExtend' instances for IO,
this instance will perform concurrently.
-}
monadAndExtend :: Monad m -> Extend m -> Apply m
monadAndExtend monad extend = ap
  (Monad.functor monad)
  (\ mAToB mA -> Bind.joinMap (Monad.bind monad)
    (\ mAToB -> Apply.ap (Monad.apply monad) mAToB mA)
    (Extend.duplicate extend mAToB))
