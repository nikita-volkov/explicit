module Explicit.Instances.Maybe where

import Explicit.Prelude hiding (empty, alt)
import qualified BasePrelude as Base
import qualified Explicit.Empty as Empty
import qualified Explicit.Alt as Alt
import qualified Explicit.Alternative as Alternative


empty :: Empty.Empty Maybe
empty =
  Empty.Empty Nothing

alt :: Alt.Alt Maybe
alt =
  Alt.Alt (Base.<|>)

-- alternative :: Alternative.Alternative Maybe
-- alternative =
--   Alternative.Alternative empty alt
