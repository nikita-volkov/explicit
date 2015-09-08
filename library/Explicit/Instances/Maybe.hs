module Explicit.Instances.Maybe where

import Explicit.Prelude hiding (empty, alt)
import qualified BasePrelude as Base
import qualified Explicit.Classes.Empty as Empty
import qualified Explicit.Classes.Alt as Alt
import qualified Explicit.Classes.Alternative as Alternative


empty :: Empty.Empty Maybe
empty =
  Empty.Empty Nothing

alt :: Alt.Alt Maybe
alt =
  Alt.Alt (Base.<|>)

-- alternative :: Alternative.Alternative Maybe
-- alternative =
--   Alternative.Alternative empty alt
