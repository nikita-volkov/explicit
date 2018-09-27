module Explicit.Classes.Accessors.Functor where

import Explicit.Classes.Types
import qualified Explicit.Prelude as Prelude


map :: Functor m -> (a -> b) -> (m a -> m b)
map (Functor x) = x
