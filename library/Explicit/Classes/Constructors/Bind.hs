module Explicit.Classes.Constructors.Bind where

import Explicit.Prelude hiding (ap, map, Functor(..))
import Explicit.Classes.Types
import qualified Explicit.Classes.Accessors.Functor as Functor
import qualified Explicit.Classes.Accessors.Apply as Apply


join :: Apply m -> (forall a. m (m a) -> m a) -> Bind m
join apply join = Bind apply join (\ m f -> join (Apply.map apply f m))
