module Explicit.Classes.Accessors.Bind where

import Explicit.Prelude hiding (Bind(..), map)
import Explicit.Classes.Types


join :: Bind m -> m (m a) -> m a
join (Bind _ join _) = join

bind :: Bind m -> m a -> (a -> m b) -> m b
bind (Bind _ _ bind) = bind

joinMap :: Bind m -> (a -> m b) -> (m a -> m b)
joinMap = flip . bind
