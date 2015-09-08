module Explicit.Classes.Point where

import qualified Explicit.Prelude as Prelude


newtype Point m =
  Point (forall a. a -> m a)

point :: Point m -> a -> m a
point =
  \(Point x) -> x
