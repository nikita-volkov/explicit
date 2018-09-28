module Explicit.Classes.Accessors.Profunctor where

import Explicit.Prelude
import Explicit.Classes.Types


dimap :: Profunctor p -> (a -> b) -> (c -> d) -> p b c -> p a d
dimap (Profunctor dimap _ _) = dimap
