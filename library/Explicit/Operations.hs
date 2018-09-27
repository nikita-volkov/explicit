-- |
-- Operations and utilities for their composition.
module Explicit.Operations where

import Explicit.Prelude


type Append a =
  a -> a -> a

type Point m =
  forall a. a -> m a

type Map m =
  forall a b. (a -> b) -> (m a -> m b)

type Map2 m =
  forall a b c. (a -> b -> c) -> (m a -> m b -> m c)

type Map3 m =
  forall a b c d. (a -> b -> c -> d) -> (m a -> m b -> m c -> m d)

type Map4 m =
  forall a b c d e. (a -> b -> c -> d -> e) -> (m a -> m b -> m c -> m d -> m e)

type Map5 m =
  forall a b c d e f. (a -> b -> c -> d -> e -> f) -> (m a -> m b -> m c -> m d -> m e -> m f)

type Ap m =
  forall a b. m (a -> b) -> (m a -> m b)

type Join m =
  forall a. m (m a) -> m a

type JoinMap m =
  forall a b. (a -> m b) -> (m a -> m b)

type Fork m =
  forall a. m a -> m (m a)

type Copoint m =
  forall a. m a -> a

type Concat m a =
  Reduce m a a

type Reduce m a b =
  m a -> b

type Foldr m a =
  forall b. (a -> b -> b) -> b -> Reduce m a b

type Producer a =
  forall b. (a -> b -> b) -> b -> b

concat :: Append a -> a -> Foldr m a -> Concat m a
concat =
  \append def foldr -> foldr append def

map2 :: Ap m -> Map m -> Map2 m
map2 =
  \ap map f mA mB -> ap (map f mA) mB

map3 :: Ap m -> Map m -> Map3 m
map3 =
  \ap map f mA mB mC -> ap (map2 ap map f mA mB) mC

map4 :: Ap m -> Map m -> Map4 m
map4 =
  \ap map f mA mB mC mD -> ap (map3 ap map f mA mB mC) mD

map5 :: Ap m -> Map m -> Map5 m
map5 =
  \ap map f mA mB mC mD mE -> ap (map4 ap map f mA mB mC mD) mE

joinMap :: Join m -> Map m -> JoinMap m
joinMap =
  \join map -> \f -> join . map f

join :: JoinMap m -> Join m
join =
  \joinMap -> joinMap id
