module Explicit.Classes.Alt where

import Explicit.Prelude
import qualified Explicit.Classes.Ap as Ap


newtype Alt m =
  Alt { alt :: forall a. m a -> m a -> m a }

