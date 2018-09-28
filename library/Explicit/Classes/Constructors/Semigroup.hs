module Explicit.Classes.Constructors.Semigroup where

import Explicit.Prelude (coerce)
import Explicit.Classes.Types


{-|
Lift alt into semigroup.
-}
alt :: Alt m -> Semigroup (m a)
alt (Alt _ assoc) = Semigroup assoc
