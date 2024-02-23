/**
 * Generate a markdown file featuring all the environment variables and their example values.
 */

const fs = require('fs');
const Yaml = require('js-yaml');

const sourceFile = '.tugboat/env-vars.yml';
const destFile = 'content/vars.md';
const output = [];

try {
  // Read the variable data.
  const data = Yaml.load(fs.readFileSync(sourceFile, 'utf8'));

  // Iterate over the sections to print the headings.
  data.sections.forEach(section => {
    // Print the section name.
    output.push(`## ${section.name}`);
    output.push('');

    // Add the section description.
    if (typeof section.desc !== 'undefined') {
      output.push(`${section.desc}`);
      output.push('');
    }

    // Protect against empty sections.
    section.vars = section.vars || [];

    // Create the table headings.
    output.push('| Variable Name | Description | Example Value |');
    output.push('|:--------------|:------------|:--------------|');

    // Iterate over all variables in each section.
    section.vars.forEach(variable => {
      // Ensure we have a value so the app doesn't die.
      let envVarName = `process.env.${variable.name}`;
      let envVarVal = '';
      if (typeof eval(envVarName) !== 'undefined') {
        envVarVal = eval(envVarName);
      }

      // Add the row to the table.
      output.push(`| **\`${variable.name}\`** | ${variable.desc} | ${envVarVal} |`);
    });

    output.push('');
  });

  // Write the file.
  fs.writeFileSync(destFile, output.join('\n'));
  console.log(`Wrote variables to ${destFile}`);
} catch (e) {
  console.log(e);
}
