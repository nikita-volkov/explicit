module Explicit.Classes.Constructors.Apply where

import Explicit.Prelude hiding (ap, map, Functor(..), Applicative(..))
import Explicit.Classes.Types
import qualified Explicit.Classes.Accessors.Functor as Functor


ap :: Functor m -> (forall a b. m (a -> b) -> (m a -> m b)) -> Apply m
ap functor ap = Apply functor ap
  (\ a b -> ap (Functor.map functor (const id) a) b)
  (\ a b -> ap (Functor.map functor const a) b)
  (\ f a b -> ap (Functor.map functor f a) b)

applicative :: Applicative m -> Apply m
applicative (Applicative _ apply) = apply
