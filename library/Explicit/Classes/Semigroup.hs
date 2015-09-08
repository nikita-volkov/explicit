module Explicit.Classes.Semigroup where

import Explicit.Prelude


type Semigroup a =
  Append a

type Append a =
  a -> a -> a


