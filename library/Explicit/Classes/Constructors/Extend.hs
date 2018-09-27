module Explicit.Classes.Constructors.Extend where

import Explicit.Prelude hiding (Functor, Extend)
import Explicit.Classes.Types
import qualified Explicit.Classes.Accessors.Functor as Functor


duplicated :: Functor m -> (forall a. m a -> m (m a)) -> Extend m
duplicated functor duplicated = Extend functor duplicated (\ f -> Functor.map functor f . duplicated)
