module Explicit.Classes.Accessors.Extend where

import Explicit.Prelude hiding (Functor, Extend)
import Explicit.Classes.Types
import qualified Explicit.Classes.Accessors.Functor as Functor


functor :: Extend m -> Functor m
functor (Extend functor _ _) = functor

duplicate :: Extend m -> m a -> m (m a)
duplicate (Extend _ duplicate _) = duplicate
