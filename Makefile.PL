use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Graphics::SANE',
    VERSION_FROM      => 'lib/Graphics/SANE.pm', # finds $VERSION
    PREREQ_PM         => {}, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Graphics/SANE.pm', # retrieve abstract from module
       AUTHOR         => 'Thomas Pfau <pfau@nbpfaus.net>') : ()),
    LIBS              => ['-lsane'], # e.g., '-lm'
    DEFINE            => '', # e.g., '-DHAVE_SOMETHING'
    INC               => '-I.', # e.g., '-I. -I/usr/include/other'
	# Un-comment this if you add C files to link with later:
    # OBJECT            => '$(O_FILES)', # link all the C files too
    TYPEMAPS          => ['typemap'],
);
if  (eval {require ExtUtils::Constant; 1}) {
  # If you edit these definitions to change the constants used by this module,
  # you will need to use the generated const-c.inc and const-xs.inc
  # files to replace their "fallback" counterparts before distributing your
  # changes.
  my @names = (qw(SANE_STATUS_ACCESS_DENIED SANE_STATUS_CANCELLED
		  SANE_STATUS_COVER_OPEN SANE_STATUS_DEVICE_BUSY
		  SANE_STATUS_EOF SANE_STATUS_GOOD SANE_STATUS_INVAL
		  SANE_STATUS_IO_ERROR SANE_STATUS_JAMMED SANE_STATUS_NO_DOCS
		  SANE_STATUS_NO_MEM SANE_STATUS_UNSUPPORTED));
  ExtUtils::Constant::WriteConstants(
                                     NAME         => 'Graphics::SANE',
                                     NAMES        => \@names,
                                     DEFAULT_TYPE => 'IV',
                                     C_FILE       => 'const-c.inc',
                                     XS_FILE      => 'const-xs.inc',
                                  );

}
else {
  use File::Copy;
  use File::Spec;
  foreach my $file ('const-c.inc', 'const-xs.inc') {
    my $fallback = File::Spec->catfile('fallback', $file);
    copy ($fallback, $file) or die "Can't copy $fallback to $file: $!";
  }
}
