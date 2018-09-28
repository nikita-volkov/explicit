module Explicit.Classes.Types where

import Explicit.Prelude (Either, Void, NonEmpty)


-- * Type-classes
-------------------------

-- ** Monoids
-------------------------

newtype Semigroup a = Semigroup (SemigroupAssocFn a)

data Monoid a = Monoid (Semigroup a) a


-- ** Covariant Functors
-------------------------

newtype Functor m = Functor (MapFn m)

newtype Pointed m = Pointed (PointFn m)

data Apply m = Apply (Functor m) (ApFn m) (ApRightFn m) (ApLeftFn m) (Map2Fn m)

data Applicative m = Applicative (Pointed m) (Apply m)

data Bind m = Bind (Apply m) (JoinFn m) (BindFn m)

data Monad m = Monad (Applicative m) (Bind m)

data Alt m = Alt (Functor m) (AltAssocFn m)

data Plus m = Plus (Alt m) (PlusIdentityFn m)

data Alternative m = Alternative (Applicative m) (Plus m) (SomeFn m) (ManyFn m)


-- ** Contravariant functors
-------------------------

data Contravariant m = Contravariant (ContramapFn m) (ReplaceFn m)

data Divisible m = Divisible (Contravariant m) (DivideFn m) (ConquerFn m)

data Decidable m = Decidable (Divisible m) (LoseFn m) (ChooseFn m)


-- ** Comonads
-------------------------

newtype Copointed m = Copointed (CopointFn m)

data Extend m = Extend (Functor m) (DuplicateFn m) (ExtendFn m)

data Comonad m = Comonad (Copointed m) (Extend m)


-- ** Profunctors
-------------------------

data Profunctor p = Profunctor (DimapFn p) (ContramapInputFn p) (MapOutputFn p)

data Strong p = Strong (Profunctor p) (ContramapFirstFn p) (MapSecondFn p)

data Choice p = Choice (Profunctor p) (ContramapLeftFn p) (MapRightFn p)


-- ** Categories
-------------------------

newtype Semigroupoid p = Semigroupoid (ComposeFn p)

data Category p = Category (Semigroupoid p) (CategoryIdentityFn p)

data Arrow p = Arrow (Category p) (Strong p) (ArrFn p) (MapPairFn p)

data ArrowZero p = ArrowZero (Arrow p) (ArrowPlusIdentityFn p)

data ArrowPlus p = ArrowPlus (ArrowZero p) (ArrowAssocFn p)

data ArrowChoice p = ArrowChoice (Arrow p) (Choice p) (MapEitherFn p) (ChoiceFanInFn p)

data ArrowApply p = ArrowApply (Arrow p) (AppFn p)

data ArrowLoop p = ArrowLoop (Arrow p) (LoopFn p)


-- * Functions
-------------------------

type SemigroupAssocFn a = a -> a -> a

type MapFn m = forall a b. (a -> b) -> (m a -> m b)

type PointFn m = forall a. a -> m a

type ApFn m = forall a b. m (a -> b) -> (m a -> m b)

type ApRightFn m = forall a b. m a -> m b -> m b

type ApLeftFn m = forall a b. m a -> m b -> m a

type Map2Fn m = forall a b c. (a -> b -> c) -> m a -> m b -> m c

type JoinFn m = forall a. m (m a) -> m a

type BindFn m = forall a b. m a -> (a -> m b) -> m b

type AltAssocFn m = forall a. m a -> m a -> m a

type PlusIdentityFn m = forall a. m a

type SomeFn m = forall a. m a -> m (NonEmpty a)

type ManyFn m = forall a. m a -> m [a]

type ContramapFn m = forall a b. (a -> b) -> m b -> m a

type ReplaceFn m = forall a b. b -> m b -> m a

type DivideFn m = forall a b c. (a -> (b, c)) -> m b -> m c -> m a

type ConquerFn m = forall a. m a

type LoseFn m = forall a. (a -> Void) -> m a

type ChooseFn m = forall a b c. (a -> Either b c) -> m b -> m c -> m a

type CopointFn m = forall a. m a -> a

type DuplicateFn m = forall a. m a -> m (m a)

type ExtendFn m = forall a b. (m a -> b) -> m a -> m b

type DimapFn p = forall a b c d. (a -> b) -> (c -> d) -> p b c -> p a d

type ContramapInputFn p = forall a b c. (a -> b) -> p b c -> p a c

type MapOutputFn p = forall a b c. (b -> c) -> p a b -> p a c

type ContramapFirstFn p = forall a b c. p a b -> p (a, c) (b, c)

type MapSecondFn p = forall a b c. p a b -> p (c, a) (c, b)

type ContramapLeftFn p = forall a b c. p a b -> p (Either a c) (Either b c)

type MapRightFn p = forall a b c. p a b -> p (Either c a) (Either c b)

type ComposeFn p = forall a b c. p b c -> p a b -> p a c

type CategoryIdentityFn p = forall a. p a a

type ArrFn p = forall a b. (a -> b) -> p a b

type MapPairFn p = forall a b c d. p a b -> p c d -> p (a, c) (b, d)

type ArrowPlusIdentityFn p = forall a b. p a b

type ArrowAssocFn p = forall a b. p a b -> p a b -> p a b

type MapEitherFn p = forall a b c d. p a b -> p c d -> p (Either a c) (Either b d)

type ChoiceFanInFn p = forall a b c. p a c -> p b c -> p (Either a b) c

type AppFn p = forall a b. p (p a b, a) b

type LoopFn p = forall a b c. p (a, c) (b, c) -> p a b
