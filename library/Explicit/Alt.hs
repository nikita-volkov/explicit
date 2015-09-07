module Explicit.Alt where

import Explicit.Prelude
import qualified Explicit.Ap as Ap


newtype Alt m =
  Alt { alt :: forall a. m a -> m a -> m a }

