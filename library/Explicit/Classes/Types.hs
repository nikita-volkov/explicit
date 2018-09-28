module Explicit.Classes.Types where

import Explicit.Prelude (Either, Void, NonEmpty)


-- * Monoids
-------------------------

newtype Semigroup a = Semigroup (a -> a -> a)

data Monoid a = Monoid (Semigroup a) a


-- * Covariant Functors
-------------------------

newtype Functor m = Functor (forall a b. (a -> b) -> (m a -> m b))

newtype Pointed m = Pointed (forall a. a -> m a)

data Apply m = Apply
  (Functor m)
  (forall a b. m (a -> b) -> (m a -> m b))
  (forall a b. m a -> m b -> m b)
  (forall a b. m a -> m b -> m a)
  (forall a b c. (a -> b -> c) -> m a -> m b -> m c)

data Applicative m = Applicative (Pointed m) (Apply m)

data Bind m = Bind
  (Apply m)
  (forall a. m (m a) -> m a)
  (forall a b. m a -> (a -> m b) -> m b)

data Monad m = Monad (Applicative m) (Bind m)

data Alt m = Alt (Functor m) (forall a. m a -> m a -> m a)

data Plus m = Plus (Alt m) (forall a. m a)

data Alternative m = Alternative (Applicative m) (Plus m) (forall a. m a -> m (NonEmpty a)) (forall a. m a -> m [a])


-- * Contravariant functors
-------------------------

data Contravariant m = Contravariant
  (forall a b. (a -> b) -> m b -> m a)
  (forall a b. b -> m b -> m a)

data Divisible m = Divisible
  (Contravariant m)
  (forall a b c. (a -> (b, c)) -> m b -> m c -> m a)
  (forall a. m a)

data Decidable m = Decidable
  (Divisible m)
  (forall a. (a -> Void) -> m a)
  (forall a b c. (a -> Either b c) -> m b -> m c -> m a)


-- * Comonads
-------------------------

newtype Copointed m = Copointed (forall a. m a -> a)

data Extend m = Extend
  (Functor m)
  (forall a. m a -> m (m a))
  (forall a b. (m a -> b) -> m a -> m b)

data Comonad m = Comonad (Copointed m) (Extend m)


-- * Profunctors
-------------------------

data Profunctor p = Profunctor
  (forall a b c d. (a -> b) -> (c -> d) -> p b c -> p a d)
  (forall a b c. (a -> b) -> p b c -> p a c)
  (forall a b c. (b -> c) -> p a b -> p a c)

data Strong p = Strong
  (Profunctor p)
  (forall a b c. p a b -> p (a, c) (b, c))
  (forall a b c. p a b -> p (c, a) (c, b))

data Choice p = Choice
  (Profunctor p)
  (forall a b c. p a b -> p (Either a c) (Either b c))
  (forall a b c. p a b -> p (Either c a) (Either c b))


-- * Categories
-------------------------

newtype Semigroupoid p = Semigroupoid (forall a b c. p b c -> p a b -> p a c)

data Category p = Category
  (Semigroupoid p)
  (forall a. p a a)

data Arrow p = Arrow
  (Category p)
  (Strong p)
  (forall a b. (a -> b) -> p a b)
  (forall a b c d. p a b -> p c d -> p (a, c) (b, d))

data ArrowZero p = ArrowZero
  (Arrow p)
  (forall a b. p a b)

data ArrowPlus p = ArrowPlus
  (ArrowZero p)
  (forall a b. p a b -> p a b -> p a b)

data ArrowChoice p = ArrowChoice
  (Arrow p)
  (Choice p)
  (forall a b c d. p a b -> p c d -> p (Either a c) (Either b d))
  (forall a b c. p a c -> p b c -> p (Either a b) c)

data ArrowApply p = ArrowApply
  (Arrow p)
  (forall a b. p (p a b, a) b)

data ArrowLoop p = ArrowLoop
  (Arrow p)
  (forall a b c. p (a, c) (b, c) -> p a b)
