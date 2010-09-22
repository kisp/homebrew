require 'formula'

class Unison < Formula
  url 'http://www.seas.upenn.edu/~bcpierce/unison//download/releases/unison-2.32.52/unison-2.32.52.tar.gz'
  homepage 'http://www.cis.upenn.edu/~bcpierce/unison/'
  md5 '0701f095c1721776a0454b94607eda48'

  bottle do
    cellar :any
    revision 1
    sha1 "dd7f286a9b2604953e8d0733c316d7e087a48016" => :yosemite
    sha1 "8ca37b6fc00c806cf7f453a4b4bf0b287280b2e5" => :mavericks
    sha1 "6972899653b6f368a0c9fd232504922414d5cbfa" => :mountain_lion
  end

  depends_on 'objective-caml' => :build

  # fixed upstream in https://webdav.seas.upenn.edu/viewvc/unison?view=revision&revision=530
  patch :DATA

  def install
    ENV.j1
    ENV.delete "CFLAGS" # ocamlopt reads CFLAGS but doesn't understand common options
    ENV.delete "NAME" # https://github.com/Homebrew/homebrew/issues/28642
    system "make ./mkProjectInfo"
    system "make UISTYLE=text"
    bin.install 'unison'
  end
end

__END__
diff --git a/update.mli b/update.mli
index dc1e018..c99c704 100644
--- a/update.mli
+++ b/update.mli
@@ -1,7 +1,7 @@
 (* Unison file synchronizer: src/update.mli *)
 (* Copyright 1999-2009, Benjamin C. Pierce (see COPYING for details) *)
 
-module NameMap : Map.S with type key = Name.t
+module NameMap : MyMap.S with type key = Name.t
 
 type archive =
     ArchiveDir of Props.t * archive NameMap.t
