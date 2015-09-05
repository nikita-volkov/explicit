module Explicit.Point where

import qualified Explicit.Prelude as Prelude


type Point m =
  forall a. a -> m a

point :: Point m -> a -> m a
point =
  Prelude.id
