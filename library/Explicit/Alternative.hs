module Explicit.Alternative where

import Explicit.Prelude
import qualified Explicit.Functor as Functor
import qualified Explicit.Applicative as Applicative
import qualified Explicit.Alt as Alt
import qualified Explicit.Empty as Empty
import qualified Explicit.Point as Point


data Alternative m =
  Alternative {
    toApplicative :: !(Applicative.Applicative m),
    toAlt :: !(Alt.Alt m),
    toEmpty :: !(Empty.Empty m)
  }

toFunctor :: Alternative m -> Functor.Functor m
toFunctor =
  Applicative.toFunctor . toApplicative

toPoint :: Alternative m -> Point.Point m
toPoint =
  Applicative.toPoint . toApplicative

point :: Alternative m -> a -> m a
point =
  Point.point . toPoint

alt :: Alternative m -> m a -> m a -> m a
alt =
  Alt.alt . toAlt
