module Explicit.Classes.Accessors.Apply where

import Explicit.Prelude hiding (ap, map, Functor(..))
import Explicit.Classes.Types
import qualified Explicit.Classes.Accessors.Functor as Functor


functor :: Apply m -> Functor m
functor (Apply functor _ _ _ _) = functor

map :: Apply m -> (a -> b) -> (m a -> m b)
map = Functor.map . functor

map2 :: Apply m -> (a -> b -> c) -> (m a -> m b -> m c)
map2 (Apply _ _ _ _ x) = x

map3 :: Apply m -> (a -> b -> c -> d) -> (m a -> m b -> m c -> m d)
map3 (Apply functor ap _ _ _) aToBToCToD mA mB mC = let
  mBToCToD = Functor.map functor aToBToCToD mA
  mCToD = ap mBToCToD mB
  mD = ap mCToD mC
  in mD
