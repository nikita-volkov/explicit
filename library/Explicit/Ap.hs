module Explicit.Ap where

import qualified Explicit.Prelude as Prelude


type Ap m =
  forall a b. m (a -> b) -> (m a -> m b)

ap :: Ap m -> m (a -> b) -> (m a -> m b)
ap =
  Prelude.id
