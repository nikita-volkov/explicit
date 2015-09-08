module Explicit.Classes.Monad where

import Explicit.Prelude
import qualified Explicit.Classes.Functor as Functor
import qualified Explicit.Classes.Point as Point
import qualified Explicit.Classes.Ap as Ap
import qualified Explicit.Classes.Applicative as Applicative


data Monad m =
  Monad {
    applicativeInstance :: !(Applicative.Applicative m),
    joinOrJoinMapInstance :: !(Either (Join m) (JoinMap m))
  }

newtype Join m =
  Join (forall a. m (m a) -> m a)

newtype JoinMap m =
  JoinMap (forall a b. (a -> m b) -> (m a -> m b))

map :: Monad m -> (a -> b) -> (m a -> m b)
map =
  Applicative.map . applicativeInstance

point :: Monad m -> a -> m a
point =
  Point.point . Applicative.pointInstance . applicativeInstance

ap :: Monad m -> m (a -> b) -> (m a -> m b)
ap =
  Ap.ap . Applicative.apInstance . applicativeInstance

join :: Monad m -> m (m a) -> m a
join =
  \m -> either (\(Join x) -> x) (\(JoinMap joinMap) -> joinMap id) (joinOrJoinMapInstance m)

joinMap :: Monad m -> (a -> m b) -> (m a -> m b)
joinMap =
  \m -> either (\(Join join) f -> join . map m f) (\(JoinMap joinMap) -> joinMap) (joinOrJoinMapInstance m)
