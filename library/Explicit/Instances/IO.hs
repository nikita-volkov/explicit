module Explicit.Instances.IO where

import Explicit.Prelude hiding (Functor, Applicative, Alternative, Monad, Semigroup, Monoid)
import Explicit.Classes.Types
import qualified Explicit.Prelude as Prelude
import qualified Explicit.Operations.IO as Operations
import qualified Explicit.Classes.Constructors.Extend as Extend
import qualified Explicit.Classes.Constructors.Apply as Apply
import qualified Explicit.Classes.Accessors.Apply as Apply


sequentialSemigroup :: Semigroup a -> Semigroup (IO a)
sequentialSemigroup (Semigroup append) = Semigroup (Apply.map2 sequentialApply append)

concurrentSemigroup :: Semigroup a -> Semigroup (IO a)
concurrentSemigroup (Semigroup append) = Semigroup (Apply.map2 concurrentApply append)

sequentialApply :: Apply IO
sequentialApply = Apply.ap functor Operations.apSequentially

concurrentApply :: Apply IO
concurrentApply = Apply.ap functor Operations.apConcurrently

functor :: Functor IO
functor = Functor Operations.map

apply :: Apply IO
apply = Apply functor (Prelude.<*>) (Prelude.*>) (Prelude.<*) (Prelude.liftA2)

pointed :: Pointed IO
pointed = Pointed Prelude.return

applicative :: Applicative IO
applicative = Applicative pointed apply

bind :: Bind IO
bind = Bind apply Prelude.join (Prelude.>>=)

monad :: Monad IO
monad = Monad applicative bind

concurrentExtend :: Extend IO
concurrentExtend = Extend.duplicated functor Operations.fork
