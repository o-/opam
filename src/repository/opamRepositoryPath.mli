(**************************************************************************)
(*                                                                        *)
(*    Copyright 2012-2015 OCamlPro                                        *)
(*    Copyright 2012 INRIA                                                *)
(*                                                                        *)
(*  All rights reserved. This file is distributed under the terms of the  *)
(*  GNU Lesser General Public License version 2.1, with the special       *)
(*  exception on linking described in the file LICENSE.                   *)
(*                                                                        *)
(**************************************************************************)

(** Defines the file hierarchy in repositories *)

open OpamTypes

(** Repository local path: {i $opam/repo/<name>} *)
val create: OpamFilename.Dir.t -> repository_name -> dirname

(** Return the repo file *)
val repo: dirname -> OpamFile.Repo.t OpamFile.t

(** Packages folder: {i $repo/packages} *)
val packages_dir: dirname -> dirname

(** Package folder: {i $repo/packages/XXX/$NAME.$VERSION} *)
val packages: dirname -> string option -> package -> dirname

(** Return the OPAM file for a given package:
    {i $repo/packages/XXX/$NAME.$VERSION/opam} *)
val opam: dirname -> string option -> package -> OpamFile.OPAM.t OpamFile.t

(** Return the description file for a given package:
    {i $repo/packages/XXX/$NAME.VERSION/descr} *)
val descr: dirname -> string option -> package -> OpamFile.Descr.t OpamFile.t

(** urls {i $repo/package/XXX/$NAME.$VERSION/url} *)
val url: dirname -> string option -> package -> OpamFile.URL.t OpamFile.t

(** files {i $repo/packages/XXX/$NAME.$VERSION/files} *)
val files: dirname -> string option -> package -> dirname

(** Url constructor for parts of remote repositories, when applicable (http and
    rsync). Function take the repo's root url. *)
module Remote: sig
  (** Remote repo file *)
  val repo: url -> url

  (** Remote package files: {i $remote/packages} *)
  val packages_url: url -> url

  (** Remote archive {i $remote/archives/$NAME.$VERSION.tar.gz} *)
  val archive: url -> package -> url
end
