module Optics.Encoding.Class where

-- based on OpenGames.Engine.OpticClass
-- from open-games-hs

-- Question: Can this be somehow replaced with a Category instance?

class Optic o where
  (>>) :: o s t a b -> o a b p q -> o s t p q
