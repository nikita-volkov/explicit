module Explicit.Monad where

import Explicit.Prelude
import qualified Explicit.Functor as Functor
import qualified Explicit.Point as Point
import qualified Explicit.Ap as Ap
import qualified Explicit.Applicative as Applicative


data Monad m =
  Monad {
    applicative :: !(Applicative.Applicative m),
    joinOrJoinMap :: !(Either (Join m) (JoinMap m))
  }

newtype Join m =
  Join (forall a. m (m a) -> m a)

newtype JoinMap m =
  JoinMap (forall a b. (a -> m b) -> (m a -> m b))

toApplicative :: Monad m -> Applicative.Applicative m
toApplicative =
  \(Monad x _) -> x

map :: Monad m -> (a -> b) -> (m a -> m b)
map =
  Applicative.map . toApplicative

point :: Monad m -> a -> m a
point =
  Point.point . Applicative.toPoint . toApplicative

ap :: Monad m -> m (a -> b) -> (m a -> m b)
ap =
  Ap.ap . Applicative.toAp . toApplicative

join :: Monad m -> m (m a) -> m a
join =
  \m -> either (\(Join x) -> x) (\(JoinMap joinMap) -> joinMap id) (joinOrJoinMap m)

joinMap :: Monad m -> (a -> m b) -> (m a -> m b)
joinMap =
  \m -> either (\(Join join) f -> join . map m f) (\(JoinMap joinMap) -> joinMap) (joinOrJoinMap m)
