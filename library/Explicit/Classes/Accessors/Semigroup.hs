module Explicit.Classes.Accessors.Semigroup where

import Explicit.Prelude (coerce)
import Explicit.Classes.Types


append :: Semigroup a -> a -> a -> a
append = coerce
