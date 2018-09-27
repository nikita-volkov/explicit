module Explicit.Classes.Types where

import Explicit.Prelude (Either, Void)


-- * Monoids
-------------------------

newtype Semigroup a = Semigroup (a -> a -> a)

data Monoid a = Monoid (Semigroup a) a


-- * Covariant Functors
-------------------------

newtype Functor m = Functor (forall a b. (a -> b) -> (m a -> m b))

newtype Pointed m = Pointed (forall a. a -> m a)

data Apply m = Apply (Functor m) (forall a b. m (a -> b) -> (m a -> m b)) (forall a b. m a -> m b -> m b) (forall a b. m a -> m b -> m a) (forall a b c. (a -> b -> c) -> m a -> m b -> m c)

data Applicative m = Applicative (Pointed m) (Apply m)

newtype Alt m = Alt (forall a. m a -> m a -> m a)

data Bind m = Bind (Apply m) (forall a. m (m a) -> m a) (forall a b. m a -> (a -> m b) -> m b)

data Monad m = Monad (Applicative m) (Bind m)


-- * Contravariant functors
-------------------------

data Contravariant m = Contravariant (forall a b. (a -> b) -> m b -> m a) (forall a b. b -> m b -> m a)

data Divisible m = Divisible (Contravariant m) (forall a b c. (a -> (b, c)) -> m b -> m c -> m a) (forall a. m a)

data Decidable m = Decidable (Divisible m) (forall a. (a -> Void) -> m a) (forall a b c. (a -> Either b c) -> m b -> m c -> m a)


-- * Comonads
-------------------------

newtype Copointed m = Copointed (forall a. m a -> a)

data Extend m = Extend (Functor m) (forall a. m a -> m (m a)) (forall a b. (m a -> b) -> m a -> m b)

data Comonad m = Comonad (Copointed m) (Extend m)
