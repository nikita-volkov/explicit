module Explicit.Classes.Constructors.Functor where

import Explicit.Prelude ((.))
import Explicit.Classes.Types
import qualified Explicit.Prelude as Prelude
import qualified Explicit.Classes.Constructors.Apply as Apply


extend :: Extend m -> Functor m
extend (Extend functor _ _) = functor

apply :: Apply m -> Functor m
apply (Apply functor _ _ _ _) = functor

applicative :: Applicative m -> Functor m
applicative = apply . Apply.applicative
