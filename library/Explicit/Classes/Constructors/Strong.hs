module Explicit.Classes.Constructors.Strong where

import Explicit.Prelude
import Explicit.Classes.Types
import qualified Explicit.Classes.Accessors.Profunctor as ProfunctorAccessors


first :: Profunctor p -> (forall a b c. p a b -> p (a, c) (b, c)) -> Strong p
first profunctor first = Strong profunctor
  first
  (ProfunctorAccessors.dimap profunctor swap swap . first)

second :: Profunctor p -> (forall a b c. p a b -> p (c, a) (c, b)) -> Strong p
second profunctor second = Strong profunctor
  (ProfunctorAccessors.dimap profunctor swap swap . second)
  second
