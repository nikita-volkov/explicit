module Explicit.Classes.Accessors.Monad where

import Explicit.Prelude ((.))
import Explicit.Classes.Types
import qualified Explicit.Classes.Accessors.Applicative as Applicative


pointed :: Monad m -> Pointed m
pointed = Applicative.pointed . applicative

functor :: Monad m -> Functor m
functor = Applicative.functor . applicative

apply :: Monad m -> Apply m
apply = Applicative.apply . applicative

applicative :: Monad m -> Applicative m
applicative (Monad applicative _) = applicative

bind :: Monad m -> Bind m
bind (Monad _ bind) = bind
