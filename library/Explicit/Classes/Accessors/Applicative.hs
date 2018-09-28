module Explicit.Classes.Accessors.Applicative where

import Explicit.Prelude hiding (Functor(..), Applicative(..))
import Explicit.Classes.Types
import qualified Explicit.Classes.Accessors.Apply as Apply


pointed :: Applicative m -> Pointed m
pointed (Applicative pointed _) = pointed

functor :: Applicative m -> Functor m
functor = Apply.functor . apply

apply :: Applicative m -> Apply m
apply (Applicative _ apply) = apply
