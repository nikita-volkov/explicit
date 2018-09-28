module Explicit.Instances.IO where

import Explicit.Prelude hiding (Functor, Applicative, Alternative, Monad, Semigroup, Monoid, Alt)
import Explicit.Classes.Types
import qualified Explicit.Prelude as Prelude
import qualified Explicit.Operations.IO as Operations
import qualified Explicit.Classes.Constructors.Extend as Extend
import qualified Explicit.Classes.Constructors.Apply as ApplyConstructors
import qualified Explicit.Classes.Accessors.Apply as ApplyAccessors


sequentialSemigroup :: Semigroup a -> Semigroup (IO a)
sequentialSemigroup (Semigroup assoc) = Semigroup (ApplyAccessors.map2 sequentialApply assoc)

concurrentSemigroup :: Semigroup a -> Semigroup (IO a)
concurrentSemigroup (Semigroup assoc) = Semigroup (ApplyAccessors.map2 concurrentApply assoc)

sequentialMonoid :: Monoid a -> Monoid (IO a)
sequentialMonoid (Monoid aSemigroup aIdentity) = Monoid (sequentialSemigroup aSemigroup) (Prelude.return aIdentity)

concurrentMonoid :: Monoid a -> Monoid (IO a)
concurrentMonoid (Monoid aSemigroup aIdentity) = Monoid (concurrentSemigroup aSemigroup) (Prelude.return aIdentity)

pointed :: Pointed IO
pointed = Pointed Prelude.return

functor :: Functor IO
functor = Functor Operations.map

sequentialApply :: Apply IO
sequentialApply = Apply functor (Prelude.<*>) (Prelude.*>) (Prelude.<*) (Prelude.liftA2)

concurrentApply :: Apply IO
concurrentApply = ApplyConstructors.ap functor Operations.apConcurrently

sequentialApplicative :: Applicative IO
sequentialApplicative = Applicative pointed sequentialApply

concurrentApplicative :: Applicative IO
concurrentApplicative = Applicative pointed concurrentApply

sequentialBind :: Bind IO
sequentialBind = Bind sequentialApply Prelude.join (Prelude.>>=)

sequentialMonad :: Monad IO
sequentialMonad = Monad sequentialApplicative sequentialBind

concurrentExtend :: Extend IO
concurrentExtend = Extend.duplicated functor Operations.fork

competingAlt :: Alt IO
competingAlt = Alt functor Operations.compete
