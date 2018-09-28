module Explicit.Classes.Constructors.Alternative where

import Explicit.Prelude hiding (Applicative, Alternative, Plus)
import Explicit.Classes.Types


applicativeAndPlus :: Applicative m -> Plus m -> Alternative m
applicativeAndPlus applicative plus = Alternative applicative plus
  undefined
  undefined
