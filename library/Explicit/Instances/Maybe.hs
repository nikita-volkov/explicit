module Explicit.Instances.Maybe where

import Explicit.Prelude hiding (empty, alt, ap)
import qualified Explicit.Prelude as Prelude
import qualified Explicit.Classes.Empty as Empty
import qualified Explicit.Classes.Alt as Alt
import qualified Explicit.Classes.Ap as Ap
import qualified Explicit.Classes.Functor as Functor
import qualified Explicit.Classes.Alternative as Alternative
import qualified Explicit.Classes.Applicative as Applicative
import qualified Explicit.Classes.Point as Point


empty :: Empty.Empty Maybe
empty =
  Empty.Empty Nothing

point :: Point.Point Maybe
point =
  Point.Point Just

ap :: Ap.Ap Maybe
ap =
  Ap.Ap functor (Prelude.ap)

applicative :: Applicative.Applicative Maybe
applicative =
  Applicative.Applicative point ap

alt :: Alt.Alt Maybe
alt =
  Alt.Alt (Prelude.<|>)

alternative :: Alternative.Alternative Maybe
alternative =
  Alternative.Alternative applicative alt empty

functor :: Functor.Functor Maybe
functor =
  Functor.Functor $ \f -> \case
    Nothing -> Nothing
    Just x -> Just (f x)
