multibranchPipelineJob('kworkflow'){
  branchSources {
    github {
      id('1952385')
      scanCredentialsId('github-app')
      repoOwner('MarceloSpessoto')
      repository('kworkflow')
    }
  }
}
