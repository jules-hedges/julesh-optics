{-# LANGUAGE RankNTypes #-}

module Optics.Encoding.ProfunctorLens where

import Data.Profunctor
import Optics.Encoding.Class

data ProfunctorLens s t a b = ProfunctorLens (forall p. (Strong p) => p a b -> p s t)

instance Optic ProfunctorLens where
  (ProfunctorLens l) >> (ProfunctorLens m) = ProfunctorLens (l . m)
