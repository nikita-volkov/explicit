module Explicit.Empty where

import Explicit.Prelude


newtype Empty m =
  Empty (forall a. m a)


