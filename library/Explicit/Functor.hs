module Explicit.Functor where

import qualified Explicit.Prelude as Prelude


type Functor m =
  forall a b. (a -> b) -> (m a -> m b)

map :: Functor m -> (a -> b) -> (m a -> m b)
map =
  Prelude.id
