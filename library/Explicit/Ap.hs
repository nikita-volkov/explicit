module Explicit.Ap where

import qualified Explicit.Prelude as Prelude


newtype Ap m =
  Ap (forall a b. m (a -> b) -> (m a -> m b))

ap :: Ap m -> m (a -> b) -> (m a -> m b)
ap =
  \(Ap x) -> x
