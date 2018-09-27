-- |
-- <https://hackage.haskell.org/package/semigroupoids-5.0.0.3/docs/Data-Functor-Apply.html>
module Explicit.Classes.Ap where

import Explicit.Prelude hiding (ap, map, Functor(..))
import qualified Explicit.Classes.Functor as Functor; import Explicit.Classes.Functor (Functor)


data Ap m =
  Ap {
    functorInstance :: Functor m,
    ap :: forall a b. m (a -> b) -> (m a -> m b)
  }

map :: Ap m -> (a -> b) -> (m a -> m b)
map =
  Functor.map . functorInstance

map2 :: Ap m -> (a -> b -> c) -> (m a -> m b -> m c)
map2 =
  \apInstance aToBToC mA mB -> ap apInstance (map apInstance aToBToC mA) mB

map3 :: Ap m -> (a -> b -> c -> d) -> (m a -> m b -> m c -> m d)
map3 =
  \apInstance aToBToCToD mA mB mC ->
    let
      mBToCToD = map apInstance aToBToCToD mA
      mCToD = ap apInstance mBToCToD mB
      mD = ap apInstance mCToD mC
      in mD
