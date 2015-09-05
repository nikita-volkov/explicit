module Explicit.Functor where

import qualified Explicit.Prelude as Prelude


newtype Functor m =
  Functor (forall a b. (a -> b) -> (m a -> m b))

map :: Functor m -> (a -> b) -> (m a -> m b)
map =
  \(Functor x) -> x
