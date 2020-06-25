defmodule Speech do
  def random_passage() do
    ["preamble", "tom jobim", "macbeth", "gettysburg", "tao", "fergus"]
    |> Enum.random()
    |> passage()
  end

  def passage("preamble") do
    """
    When in the Course of human events, it becomes necessary for one people to
    dissolve the political bands which have connected them with another, and to
    assume among the powers of the earth, the separate and equal station to
    which the Laws of Nature and of Nature's God entitle them, a decent respect
    to the opinions of mankind requires that they should declare the causes
    which impel them to the separation.
    """
  end

  def passage("tom jobim") do
    """
    A stick, a stone
    It's the end of the road
    It's the rest of a stump
    It's a little alone

    It's a sliver of glass
    It is life, it's the sun
    It is night, it is death
    It's a trap, it's a gun
    """
  end

  def passage("macbeth") do
    """
    Tomorrow, and tomorrow, and tomorrow,
    Creeps in this petty pace from day to day,
    To the last syllable of recorded time;
    And all our yesterdays have lighted fools
    The way to dusty death. Out, out, brief candle!
    Life's but a walking shadow, a poor player,
    That struts and frets his hour upon the stage,
    And then is heard no more. It is a tale
    Told by an idiot, full of sound and fury,
    Signifying nothing.
    """
  end

  def passage("gettysburg") do
    """
    Four score and seven years ago
    our fathers brought forth on this continent,
    a new nation,
    conceived in Liberty,
    and dedicated to the proposition
    that all men are created equal.
    """
  end

  def passage("tao") do
    """
    The highest sage shares his moral possessions with others.  The next in
    wisdom shares his material possessions with others.
    """
  end

  # Who goes with Fergus? — W.B. Yeats
  def passage("fergus") do
    """
    Who will go drive with Fergus now,
    And pierce the deep wood's woven shade,
    And dance upon the level shore?
    Young man, lift up your russet brow,
    And lift your tender eyelids, maid
    And brood on hopes and fear no more.

    And no more turn aside and brood
    Upon love's bitter mystery;
    For Fergus rules the brazen cars,
    And rules the shadows of the wood,
    And the white breast of the dim sea
    And all dishevelled wandering stars.
    """
  end
end
