{-# LANGUAGE GADTs #-}

module Optics.Encoding.CoendLens where

import Optics.Encoding.Class

data CoendLens s t a b where
  CoendLens :: (s -> (z, a)) -> (z -> b -> t) -> CoendLens s t a b

instance Optic CoendLens where
  (CoendLens v1 u1) >> (CoendLens v2 u2) = CoendLens v u
    where v s = let (z1, a) = v1 s
                    (z2, p) = v2 a
                 in ((z1, z2), p)
          u (z1, z2) = u1 z1 . u2 z2
