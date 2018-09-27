module Explicit.Classes.Accessors.Pointed where

import Explicit.Classes.Types
import qualified Explicit.Prelude as Prelude


point :: Pointed m -> a -> m a
point (Pointed x) = x
