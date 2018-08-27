# encoding: utf-8
require 'strscan'

module Borkalyzer
  extend self

  VERSION = '1.0.1'

  BEGINNING_REGEXP = /^an|^a|^en|^e|^f|^o|^u|^the$|^bork$/.freeze
  ENDING_REGEXP = /tion$|a$|e$|ow$|ow$|o$|u$/.freeze

  module StringMethods
    def bork; Borkalyzer.bork(self); end
  end


  def bork(string)
    result = ''
    s = StringScanner.new(string)
    until s.eos? do
      word = s.scan(/\w+|\W+/)
      result << if( word =~ /^\W+$/ )
                  tr_nonword word
                else
                  tr_word word
                end
    end
    result
  end


  def monkey_patch(mod)
    mod.send :include, self.const_get(:StringMethods)
  end

private

  def tr_nonword(nonword)
    if nonword =~ /\n/
      nonword + "Bork Bork Bork!\n"
    else
      nonword
    end
  end

  def tr_word(word)
    return if word.nil?
    capitalized = (word == word.capitalize)
    upcased     = (word == word.upcase)
    array = split(word.downcase)
    borked = tr_beginning(array[0]) + tr_middle(array[1]) + tr_end(array[2])
    borked = borked.capitalize if capitalized
    borked = borked.upcase if upcased
    return borked
  end


  def split(word)
    b = beginning(word)
    [b[0]] + ending(b[1])
  end


  def beginning(word)
    result = word.partition BEGINNING_REGEXP
    result[0] == "" ? result[1..2] : ["", word]
  end


  def ending(word)
    result = word.rpartition ENDING_REGEXP
    result[1] == "" ? [word, ""] : result[0..1]
  end



  def matches(regexp:, word:)
    m = regexp.match(word)
    m.nil? ? m : m.captures.join
  end


  def beginning_transforms
    @beginning_transforms ||= { 'a'  => 'e',
                                'an' => 'un',
                                'au' => 'oo',
                                'e'  => 'i',
                                'en' => 'ee',
                                'i'  => 'e',
                                'o'  => 'oo',
                                'the' => 'zee'
                              }
  end


  def ending_transforms
    @ending_transforms ||= { 'au' => 'oo',
                             'e'  => 'e-a',
                             'o'  => 'u',
                             'ow' => 'oo',
                             'tion' => 'shun',
                             'u'  => 'oo'
                           }
  end


  def tr_part(lookup:, part:)
    lookup.has_key?(part) ? lookup[part] : part
  end


  def tr_beginning(part)
    tr_part part: part, lookup: beginning_transforms
  end


  def tr_end(part)
    tr_part part: part, lookup: ending_transforms
  end


  def middle_transforms
    @middle_transforms ||= { 'a'  => 'e',
                             'an' => 'un',
                             'au' => 'oo',
                             'ew' => 'oo',
                             'f'  => 'ff',
                             'i'  => 'e',
                             'ii' => 'eei',
                             'ir' => 'ur',
                             'o'  => 'u',
                             'ow' => 'oo',
                             'u'  => 'oo',
                             'v'  => 'f',
                             'w'  => 'v'
                           }
  end


  def tr_middle(middle)
    result = ''
    s = StringScanner.new middle
    until s.eos? do
      ch = s.scan(/./)
      peek = ch + s.peek(1)
      result << if( middle_transforms.has_key?(peek) )
                  s.pos += 1 unless s.eos?
                  middle_transforms[peek]
                else
                  tr_part part: ch, lookup: middle_transforms
                end
    end
    result
  end

end

if defined?(Rails)
  Borkalyzer.monkey_patch(String)
end
